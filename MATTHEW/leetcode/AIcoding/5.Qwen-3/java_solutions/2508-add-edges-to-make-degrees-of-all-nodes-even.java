public class Solution {

import java.util.*;

public class Solution {
    public int[] findSolution(Node[] nodes) {
        List<Integer> result = new ArrayList<>();
        Set<Integer> oddDegrees = new HashSet<>();
        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i].degree % 2 == 1) {
                oddDegrees.add(i);
            }
        }
        if (oddDegrees.size() % 2 != 0) {
            return new int[0];
        }
        Iterator<Integer> it = oddDegrees.iterator();
        while (it.hasNext()) {
            int u = it.next();
            int v = it.next();
            result.add(u);
            result.add(v);
        }
        int[] answer = new int[result.size()];
        for (int i = 0; i < answer.length; i++) {
            answer[i] = result.get(i);
        }
        return answer;
    }

    static class Node {
        int degree;
        Node(int degree) {
            this.degree = degree;
        }
    }
}
}