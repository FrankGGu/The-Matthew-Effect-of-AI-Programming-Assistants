class Solution {
    public List<Double> seasonalSalesAnalysis(List<List<Integer>> sales) {
        List<Double> result = new ArrayList<>();
        int n = sales.size();

        for (int i = 0; i < 4; i++) {
            double sum = 0;
            for (int j = 0; j < n; j++) {
                sum += sales.get(j).get(i);
            }
            result.add(sum / n);
        }

        return result;
    }
}