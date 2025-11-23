import java.util.*;

class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        int n = s.length();
        boolean[] visited = new boolean[n];
        String smallest = s;
        Queue<String> queue = new LinkedList<>();
        queue.offer(s);
        visited[0] = true;

        while (!queue.isEmpty()) {
            String curr = queue.poll();
            if (curr.compareTo(smallest) < 0) {
                smallest = curr;
            }

            String add = add(curr, a);
            if (!visited[0]) {
                queue.offer(add);
                visited[0] = true;
            }

            String rotate = rotate(curr, b);
            int rotateIndex = Integer.parseInt(rotate.substring(0,1));
            if (!visited[rotateIndex]) {
                queue.offer(rotate);
                visited[rotateIndex] = true;
            } else if (!rotate.equals(curr) && !contains(queue, rotate)){
                queue.offer(rotate);
            }

            if (visited[0] && visited[rotateIndex] && queue.size() > n*2){
                break;
            }
        }

        return smallest;
    }

    private String add(String s, int a) {
        char[] arr = s.toCharArray();
        for (int i = 1; i < arr.length; i += 2) {
            int digit = arr[i] - '0';
            digit = (digit + a) % 10;
            arr[i] = (char) (digit + '0');
        }
        return new String(arr);
    }

    private String rotate(String s, int b) {
        int n = s.length();
        b %= n;
        return s.substring(n - b) + s.substring(0, n - b);
    }

    private boolean contains(Queue<String> queue, String str){
        for (String s : queue){
            if (s.equals(str)){
                return true;
            }
        }
        return false;
    }
}