class FrequencyTracker {
    private int[] nums;
    private int[] freq;

    public FrequencyTracker() {
        nums = new int[100001];
        freq = new int[100001];
    }

    public void add(int number) {
        freq[nums[number]] = Math.max(0, freq[nums[number]] - 1);
        nums[number]++;
        freq[nums[number]]++;
    }

    public void deleteOne(int number) {
        if (nums[number] > 0) {
            freq[nums[number]] = Math.max(0, freq[nums[number]] - 1);
            nums[number]--;
            freq[nums[number]]++;
        }
    }

    public boolean hasFrequency(int frequency) {
        return freq[frequency] > 0;
    }
}