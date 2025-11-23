class Solution {
    public List<Integer> lastVisitedIntegers(List<String> words) {
        List<Integer> nums = new ArrayList<>();
        List<Integer> result = new ArrayList<>();
        int k = 0;

        for (String word : words) {
            if (word.equals("prev")) {
                k++;
                if (nums.size() >= k) {
                    result.add(nums.get(nums.size() - k));
                } else {
                    result.add(-1);
                }
            } else {
                nums.add(Integer.parseInt(word));
                k = 0;
            }
        }

        return result;
    }
}