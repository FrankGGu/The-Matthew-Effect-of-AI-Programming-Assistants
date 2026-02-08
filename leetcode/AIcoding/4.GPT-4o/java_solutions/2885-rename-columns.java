class Solution {
    public List<List<String>> renameColumns(List<List<String>> data, List<String> newNames) {
        List<List<String>> result = new ArrayList<>();
        for (List<String> row : data) {
            List<String> newRow = new ArrayList<>();
            for (String name : newNames) {
                int index = data.get(0).indexOf(name);
                newRow.add(row.get(index));
            }
            result.add(newRow);
        }
        return result;
    }
}