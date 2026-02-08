import java.util.*;

class Solution {
    public String findLexSmallestString(String s, int a, int b) {
        int n = s.length();
        Queue<String> q = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        q.offer(s);
        visited.add(s);
        String smallest = s;

        while (!q.isEmpty()) {
            String curr = q.poll();
            if (curr.compareTo(smallest) < 0) {
                smallest = curr;
            }

            String add = "";
            for (int i = 0; i < n; i++) {
                if (i % 2 != 0) {
                    add += (curr.charAt(i) - '0' + a) % 10;
                } else {
                    add += curr.charAt(i);
                }
            }
            String addStr = "";
            for(int i = 0; i < n; i++){
                if(i % 2 != 0){
                    addStr += (char)( (curr.charAt(i) - '0' + a) % 10 + '0');
                }else{
                    addStr += curr.charAt(i);
                }
            }

            if (!visited.contains(addStr)) {
                q.offer(addStr);
                visited.add(addStr);
            }

            String rotate = curr.substring(b) + curr.substring(0, b);
            if (!visited.contains(rotate)) {
                q.offer(rotate);
                visited.add(rotate);
            }
        }

        return smallest;
    }
}