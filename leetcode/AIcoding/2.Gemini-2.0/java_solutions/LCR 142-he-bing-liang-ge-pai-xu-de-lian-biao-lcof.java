class Solution {
    public int trainingPlan(int[] actions, int k) {
        int n = actions.length;
        int[] freq = new int[100001];
        int count = 0;
        int left = 0;
        int distinct = 0;
        for (int right = 0; right < n; right++) {
            if (freq[actions[right]] == 0) {
                distinct++;
            }
            freq[actions[right]]++;
            while (distinct > k) {
                freq[actions[left]]--;
                if (freq[actions[left]] == 0) {
                    distinct--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
}