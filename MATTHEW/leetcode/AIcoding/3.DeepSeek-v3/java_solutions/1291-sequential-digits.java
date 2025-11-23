class Solution {
    public List<Integer> sequentialDigits(int low, int high) {
        List<Integer> result = new ArrayList<>();
        String digits = "123456789";
        int n = digits.length();

        for (int length = 2; length <= n; length++) {
            for (int start = 0; start <= n - length; start++) {
                String numStr = digits.substring(start, start + length);
                int num = Integer.parseInt(numStr);
                if (num >= low && num <= high) {
                    result.add(num);
                }
            }
        }

        Collections.sort(result);
        return result;
    }
}