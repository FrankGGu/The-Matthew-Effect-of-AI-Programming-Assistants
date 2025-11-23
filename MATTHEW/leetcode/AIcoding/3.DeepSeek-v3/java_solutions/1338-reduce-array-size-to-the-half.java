class Solution {
    public int minSetSize(int[] arr) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : arr) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        List<Integer> frequencies = new ArrayList<>(frequencyMap.values());
        Collections.sort(frequencies, Collections.reverseOrder());

        int total = arr.length;
        int target = total / 2;
        int count = 0;
        int sum = 0;

        for (int freq : frequencies) {
            sum += freq;
            count++;
            if (sum >= target) {
                break;
            }
        }

        return count;
    }
}