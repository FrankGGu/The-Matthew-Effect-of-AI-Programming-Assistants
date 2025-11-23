import java.util.*;

class Solution {
    public Object[][] pivot(Object[][] data, String pivotCol, String[] groupByCols, String[] valueCols, String aggFunc) {
        Map<List<Object>, Map<Object, Object>> groupedData = new HashMap<>();
        int pivotColIndex = -1;
        List<Integer> groupByColIndices = new ArrayList<>();
        List<Integer> valueColIndices = new ArrayList<>();

        // Find column indices
        for (int i = 0; i < data[0].length; i++) {
            String colName = (String) data[0][i];
            if (colName.equals(pivotCol)) {
                pivotColIndex = i;
            } else if (Arrays.asList(groupByCols).contains(colName)) {
                groupByColIndices.add(i);
            } else if (Arrays.asList(valueCols).contains(colName)) {
                valueColIndices.add(i);
            }
        }

        // Process data rows
        for (int i = 1; i < data.length; i++) {
            Object[] row = data[i];
            List<Object> groupKey = new ArrayList<>();
            for (int colIndex : groupByColIndices) {
                groupKey.add(row[colIndex]);
            }

            Object pivotValue = row[pivotColIndex];
            Map<Object, Object> pivotMap = groupedData.computeIfAbsent(groupKey, k -> new HashMap<>());

            for (int valueColIndex : valueColIndices) {
                String valueColName = (String) data[0][valueColIndex];
                Object value = row[valueColIndex];
                String newColName = valueColName + "_" + pivotValue;

                if (aggFunc.equals("sum")) {
                    if (value instanceof Integer) {
                        pivotMap.merge(newColName, value, (oldVal, newVal) -> (Integer) oldVal + (Integer) newVal);
                    } else if (value instanceof Double) {
                        pivotMap.merge(newColName, value, (oldVal, newVal) -> (Double) oldVal + (Double) newVal);
                    }
                } else if (aggFunc.equals("count")) {
                    pivotMap.merge(newColName, 1, (oldVal, newVal) -> (Integer) oldVal + 1);
                } else if (aggFunc.equals("mean")) {
                    if (!pivotMap.containsKey(newColName + "_sum")) {
                        pivotMap.put(newColName + "_sum", value);
                        pivotMap.put(newColName + "_count", 1);
                    } else {
                        if (value instanceof Integer) {
                            pivotMap.put(newColName + "_sum", (Integer) pivotMap.get(newColName + "_sum") + (Integer) value);
                            pivotMap.put(newColName + "_count", (Integer) pivotMap.get(newColName + "_count") + 1);
                        } else if (value instanceof Double) {
                            pivotMap.put(newColName + "_sum", (Double) pivotMap.get(newColName + "_sum") + (Double) value);
                            pivotMap.put(newColName + "_count", (Integer) pivotMap.get(newColName + "_count") + 1);
                        }
                    }
                } else if (aggFunc.equals("min")) {
                    pivotMap.merge(newColName, value, (oldVal, newVal) -> {
                        if (value instanceof Integer) {
                            return Math.min((Integer) oldVal, (Integer) newVal);
                        } else if (value instanceof Double) {
                            return Math.min((Double) oldVal, (Double) newVal);
                        }
                        return newVal;
                    });
                } else if (aggFunc.equals("max")) {
                    pivotMap.merge(newColName, value, (oldVal, newVal) -> {
                        if (value instanceof Integer) {
                            return Math.max((Integer) oldVal, (Integer) newVal);
                        } else if (value instanceof Double) {
                            return Math.max((Double) oldVal, (Double) newVal);
                        }
                        return newVal;
                    });
                } else if (aggFunc.equals("first")) {
                    pivotMap.putIfAbsent(newColName, value);
                } else if (aggFunc.equals("last")) {
                    pivotMap.put(newColName, value);
                }
            }
        }

        // Prepare result
        Set<Object> allPivotValues = new HashSet<>();
        Set<String> allValueCols = new HashSet<>();
        for (Map<Object, Object> pivotMap : groupedData.values()) {
            for (Object col : pivotMap.keySet()) {
                String colStr = (String) col;
                if (colStr.endsWith("_sum") && aggFunc.equals("mean")) continue;
                if (colStr.endsWith("_count") && aggFunc.equals("mean")) continue;
                allValueCols.add(colStr);
            }
        }

        List<String> sortedValueCols = new ArrayList<>(allValueCols);
        Collections.sort(sortedValueCols);

        List<Object[]> result = new ArrayList<>();
        // Header row
        List<Object> header = new ArrayList<>();
        for (int colIndex : groupByColIndices) {
            header.add(data[0][colIndex]);
        }
        header.addAll(sortedValueCols);
        result.add(header.toArray());

        // Data rows
        for (List<Object> groupKey : groupedData.keySet()) {
            Map<Object, Object> pivotMap = groupedData.get(groupKey);
            List<Object> row = new ArrayList<>(groupKey);
            for (String col : sortedValueCols) {
                if (aggFunc.equals("mean") && pivotMap.containsKey(col + "_sum") && pivotMap.containsKey(col + "_count")) {
                    Object sum = pivotMap.get(col + "_sum");
                    int count = (Integer) pivotMap.get(col + "_count");
                    if (sum instanceof Integer) {
                        row.add((double) ((Integer) sum) / count);
                    } else if (sum instanceof Double) {
                        row.add((Double) sum / count);
                    }
                } else {
                    row.add(pivotMap.getOrDefault(col, null));
                }
            }
            result.add(row.toArray());
        }

        return result.toArray(new Object[0][]);
    }
}