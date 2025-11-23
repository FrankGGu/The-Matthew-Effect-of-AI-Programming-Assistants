class Solution {
    public String minimizeStringValue(String s) {
        char[] chars = s.toCharArray();

        int[] initialFreq = new int[26];
        int numQuestionMarks = 0;
        for (char c : chars) {
            if (c == '?') {
                numQuestionMarks++;
            } else {
                initialFreq[c - 'a']++;
            }
        }

        // This priority queue will store pairs of [frequency, char_index]
        // It's ordered by the "cost" of adding the next character.
        // The cost for character 'c' (index i) is (current_frequency[i] + 1) * (i + 1).
        // If costs are equal, prioritize smaller char_index for lexicographical tie-breaking.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            int costA = (a[0] + 1) * (a[1] + 1);
            int costB = (b[0] + 1) * (b[1] + 1);
            if (costA != costB) {
                return costA - costB;
            }
            return a[1] - b[1];
        });

        for (int i = 0; i < 26; i++) {
            pq.offer(new int[]{initialFreq[i], i});
        }

        char[] assignedChars = new char[numQuestionMarks];
        for (int i = 0; i < numQuestionMarks; i++) {
            int[] entry = pq.poll();
            int currentFreq = entry[0];
            int charIndex = entry[1];

            assignedChars[i] = (char) ('a' + charIndex);

            pq.offer(new int[]{currentFreq + 1, charIndex});
        }

        java.util.Arrays.sort(assignedChars);

        StringBuilder result = new StringBuilder();
        int assignedCharPointer = 0;
        for (char c : chars) {
            if (c == '?') {
                result.append(assignedChars[assignedCharPointer++]);
            } else {
                result.append(c);
            }
        }

        return result.toString();
    }
}