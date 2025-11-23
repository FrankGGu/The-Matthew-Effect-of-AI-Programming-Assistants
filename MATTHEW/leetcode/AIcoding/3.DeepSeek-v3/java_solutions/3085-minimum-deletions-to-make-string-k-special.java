class Solution {
    public int minimumDeletions(String word, int k) {
        int[] freq = new int[26];
        for (char c : word.toCharArray()) {
            freq[c - 'a']++;
        }

        List<Integer> counts = new ArrayList<>();
        for (int f : freq) {
            if (f > 0) {
                counts.add(f);
            }
        }
        Collections.sort(counts);

        int minDeletions = Integer.MAX_VALUE;
        for (int i = 0; i < counts.size(); i++) {
            int target = counts.get(i);
            int deletions = 0;
            for (int j = 0; j < counts.size(); j++) {
                if (j < i) {
                    deletions += counts.get(j);
                } else {
                    if (counts.get(j) > target + k) {
                        deletions += counts.get(j) - (target + k);
                    }
                }
            }
            minDeletions = Math.min(minDeletions, deletions);
        }

        return minDeletions;
    }
}