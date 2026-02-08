class Solution {
    public int findLeastNumOfUniqueInts(int[] arr, int k) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : arr) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        List<Integer> frequencies = new ArrayList<>(frequencyMap.values());
        Collections.sort(frequencies);

        int uniqueCount = frequencies.size();
        for (int freq : frequencies) {
            if (k >= freq) {
                k -= freq;
                uniqueCount--;
            } else {
                break;
            }
        }

        return uniqueCount;
    }
}