import java.util.*;

class Solution {
    public List<String> removeMethods(String[] details) {
        Set<String> usedMethods = new HashSet<>();
        Set<String> definedMethods = new HashSet<>();
        Map<String, String> methodToClass = new HashMap<>();

        for (String detail : details) {
            String[] parts = detail.split(",");
            String type = parts[0];
            String className = parts[1];
            String methodName = parts[2];

            if (type.equals("define")) {
                definedMethods.add(methodName);
                methodToClass.put(methodName, className);
            } else {
                usedMethods.add(methodName);
            }
        }

        List<String> unusedMethods = new ArrayList<>();
        for (String methodName : definedMethods) {
            if (!usedMethods.contains(methodName)) {
                unusedMethods.add(methodToClass.get(methodName) + "." + methodName);
            }
        }

        Collections.sort(unusedMethods);
        return unusedMethods;
    }
}