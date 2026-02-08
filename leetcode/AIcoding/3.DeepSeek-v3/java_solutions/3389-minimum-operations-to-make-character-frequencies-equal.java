class Solution {
    public int minOperations(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        int operations = 0;
        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < 26; i++) {
            if (freq[i] == 0) continue;
            while (seen.contains(freq[i])) {
                freq[i]--;
                operations++;
                if (freq[i] == 0) break;
            }
            if (freq[i] != 0) {
                seen.add(freq[i]);
            }
        }
        return operations;
    }
}