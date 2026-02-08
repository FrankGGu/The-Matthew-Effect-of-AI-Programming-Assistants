class Solution {
    public int[] shortestToChar(String s, char c) {
        int n = s.length();
        int[] answer = new int[n];

        // First pass: left to right
        // Stores the index of the last seen character 'c'
        // Initialize with a value that ensures initial distances are large
        int prevCIndex = -n; 
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == c) {
                prevCIndex = i;
            }
            answer[i] = i - prevCIndex;
        }

        // Second pass: right to left
        // Stores the index of the last seen character 'c' from the right
        // Initialize with a value that ensures initial distances are large
        prevCIndex = 2 * n; 
        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == c) {
                prevCIndex = i;
            }
            answer[i] = Math.min(answer[i], prevCIndex - i);
        }

        return answer;
    }
}