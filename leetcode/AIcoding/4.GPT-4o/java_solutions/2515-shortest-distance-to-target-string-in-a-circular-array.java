public class Solution {
    public int[] closestTarget(String[] words, String target, int startIndex) {
        int n = words.length;
        int[] result = new int[n];
        int targetIndex = -1;

        for (int i = 0; i < n; i++) {
            if (words[i].equals(target)) {
                targetIndex = i;
                break;
            }
        }

        if (targetIndex == -1) {
            return result;
        }

        for (int i = 0; i < n; i++) {
            int distance = Math.min(Math.abs(startIndex - i), n - Math.abs(startIndex - i));
            result[i] = distance + Math.abs(targetIndex - i) % n;
        }

        return result;
    }
}