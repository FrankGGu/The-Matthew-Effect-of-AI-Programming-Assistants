import java.util.*;

class Solution {
    public int kSimilarity(String A, String B) {
        if (A.equals(B)) return 0;
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.add(A);
        visited.add(A);
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(B)) return steps;

                char[] arr = current.toCharArray();
                for (int j = 0; j < arr.length; j++) {
                    if (arr[j] != B.charAt(j)) {
                        for (int k = j + 1; k < arr.length; k++) {
                            if (arr[k] == B.charAt(j) && arr[k] != B.charAt(k)) {
                                swap(arr, j, k);
                                String next = new String(arr);
                                if (visited.add(next)) {
                                    queue.add(next);
                                }
                                swap(arr, j, k); // backtrack
                                break;
                            }
                        }
                        break;
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private void swap(char[] arr, int i, int j) {
        char temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}