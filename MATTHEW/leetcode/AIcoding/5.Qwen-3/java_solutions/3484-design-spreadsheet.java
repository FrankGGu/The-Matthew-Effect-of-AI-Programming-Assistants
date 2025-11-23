public class Solution {

import java.util.*;

public class Spreadsheet {
    private Map<String, Cell> cells;
    private Set<String> dependents;
    private Map<String, Set<String>> dependentsMap;
    private Map<String, Set<String>> dependencies;

    public Spreadsheet() {
        cells = new HashMap<>();
        dependents = new HashSet<>();
        dependentsMap = new HashMap<>();
        dependencies = new HashMap<>();
    }

    public void setCell(String cellName, String value) {
        if (cells.containsKey(cellName)) {
            String oldValue = cells.get(cellName).value;
            if (oldValue.equals(value)) {
                return;
            }
        }

        Cell cell = new Cell();
        cell.value = value;
        cells.put(cellName, cell);

        Set<String> oldDependencies = dependencies.get(cellName);
        if (oldDependencies != null) {
            for (String dep : oldDependencies) {
                dependentsMap.get(dep).remove(cellName);
                if (dependentsMap.get(dep).isEmpty()) {
                    dependents.remove(dep);
                }
            }
        }

        Set<String> newDependencies = extractDependencies(value);
        dependencies.put(cellName, newDependencies);

        for (String dep : newDependencies) {
            dependentsMap.putIfAbsent(dep, new HashSet<>());
            dependentsMap.get(dep).add(cellName);
            dependents.add(dep);
        }

        updateDependents(cellName);
    }

    private Set<String> extractDependencies(String value) {
        Set<String> deps = new HashSet<>();
        int i = 0;
        while (i < value.length()) {
            if (value.charAt(i) == '$') {
                int j = i + 1;
                while (j < value.length() && Character.isLetterOrDigit(value.charAt(j))) {
                    j++;
                }
                if (j > i + 1) {
                    String dep = value.substring(i + 1, j);
                    deps.add(dep);
                }
                i = j;
            } else {
                i++;
            }
        }
        return deps;
    }

    private void updateDependents(String cellName) {
        Queue<String> queue = new LinkedList<>(dependentsMap.getOrDefault(cellName, new HashSet<>()));
        Set<String> visited = new HashSet<>();
        while (!queue.isEmpty()) {
            String dependent = queue.poll();
            if (visited.contains(dependent)) {
                continue;
            }
            visited.add(dependent);
            Cell dependentCell = cells.get(dependent);
            if (dependentCell == null) {
                continue;
            }
            String newValue = evaluate(dependentCell.value);
            if (!newValue.equals(dependentCell.value)) {
                dependentCell.value = newValue;
                queue.addAll(dependentsMap.getOrDefault(dependent, new HashSet<>()));
            }
        }
    }

    private String evaluate(String expression) {
        StringBuilder result = new StringBuilder();
        int i = 0;
        while (i < expression.length()) {
            if (expression.charAt(i) == '$') {
                int j = i + 1;
                while (j < expression.length() && Character.isLetterOrDigit(expression.charAt(j))) {
                    j++;
                }
                String cellName = expression.substring(i + 1, j);
                Cell cell = cells.get(cellName);
                if (cell != null) {
                    result.append(cell.value);
                } else {
                    result.append("$").append(cellName);
                }
                i = j;
            } else {
                result.append(expression.charAt(i));
                i++;
            }
        }
        return result.toString();
    }

    public String getCell(String cellName) {
        Cell cell = cells.get(cellName);
        return cell != null ? cell.value : "";
    }

    private static class Cell {
        String value;
    }
}
}