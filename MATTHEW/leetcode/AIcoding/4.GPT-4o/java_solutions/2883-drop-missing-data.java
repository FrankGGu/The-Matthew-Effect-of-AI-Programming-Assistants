class Solution {
    public List<List<String>> dropMissingData(List<List<String>> data) {
        List<List<String>> result = new ArrayList<>();
        int n = data.size();
        int m = data.get(0).size();
        boolean[] validColumns = new boolean[m];

        for (int j = 0; j < m; j++) {
            boolean hasMissing = false;
            for (int i = 0; i < n; i++) {
                if (data.get(i).get(j).equals("")) {
                    hasMissing = true;
                    break;
                }
            }
            if (!hasMissing) {
                validColumns[j] = true;
            }
        }

        for (int i = 0; i < n; i++) {
            List<String> row = new ArrayList<>();
            for (int j = 0; j < m; j++) {
                if (validColumns[j]) {
                    row.add(data.get(i).get(j));
                }
            }
            result.add(row);
        }

        return result;
    }
}