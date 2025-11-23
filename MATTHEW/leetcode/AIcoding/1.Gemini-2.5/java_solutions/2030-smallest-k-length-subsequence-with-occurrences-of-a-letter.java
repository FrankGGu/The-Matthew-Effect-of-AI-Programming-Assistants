import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public String smallestSubsequence(String s, int k, char letter, int occurrence) {
        int n = s.length();
        int[] suffixLetterCount = new int[n + 1];
        for (int i = n - 1; i >= 0; i--) {
            suffixLetterCount[i] = suffixLetterCount[i + 1];
            if (s.charAt(i) == letter) {
                suffixLetterCount[i]++;
            }
        }

        StringBuilder sb = new StringBuilder();
        int currentLetterCount = 0;

        for (int i = 0; i < n; i++) {
            char currentChar = s.charAt(i);

            while (!sb.isEmpty() && sb.charAt(sb.length() - 1) > currentChar &&
                   (sb.length() - 1 + (n - i)) >= k) {

                if (sb.charAt(sb.length() - 1) == letter) {
                    if (currentLetterCount - 1 + suffixLetterCount[i] >= occurrence) {
                        sb.deleteCharAt(sb.length() - 1);
                        currentLetterCount--;
                    } else {
                        break; 
                    }
                } else {
                    sb.deleteCharAt(sb.length() - 1);
                }
            }

            if (sb.length() < k) {
                if (currentChar == letter) {
                    sb.append(currentChar);
                    currentLetterCount++;
                } else { 
                    if (currentLetterCount + suffixLetterCount[i+1] >= occurrence) {
                        sb.append(currentChar);
                    }
                }
            }
        }

        return sb.toString();
    }
}