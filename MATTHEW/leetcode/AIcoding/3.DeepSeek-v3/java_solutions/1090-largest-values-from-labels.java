class Solution {
    public int largestValsFromLabels(int[] values, int[] labels, int numWanted, int useLimit) {
        int n = values.length;
        int[][] items = new int[n][2];
        for (int i = 0; i < n; i++) {
            items[i][0] = values[i];
            items[i][1] = labels[i];
        }
        Arrays.sort(items, (a, b) -> b[0] - a[0]);

        Map<Integer, Integer> labelCount = new HashMap<>();
        int sum = 0;
        int count = 0;

        for (int[] item : items) {
            int val = item[0];
            int label = item[1];
            if (labelCount.getOrDefault(label, 0) < useLimit) {
                sum += val;
                count++;
                labelCount.put(label, labelCount.getOrDefault(label, 0) + 1);
            }
            if (count == numWanted) {
                break;
            }
        }

        return sum;
    }
}