import java.util.*;

public class Solution {
    public List<List<Integer>> validArrangement(int[][] pairs) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();
        Map<Integer, Integer> outDegree = new HashMap<>();

        for (int[] pair : pairs) {
            graph.putIfAbsent(pair[0], new ArrayList<>());
            graph.get(pair[0]).add(pair[1]);
            outDegree.put(pair[0], outDegree.getOrDefault(pair[0], 0) + 1);
            inDegree.put(pair[1], inDegree.getOrDefault(pair[1], 0) + 1);
        }

        int start = pairs[0][0];
        for (int[] pair : pairs) {
            if (outDegree.getOrDefault(pair[0], 0) > inDegree.getOrDefault(pair[0], 0)) {
                start = pair[0];
                break;
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        Stack<Integer> stack = new Stack<>();
        stack.push(start);

        while (!stack.isEmpty()) {
            int u = stack.peek();
            if (graph.getOrDefault(u, new ArrayList<>()).isEmpty()) {
                result.add(Arrays.asList(u));
                stack.pop();
            } else {
                stack.push(graph.get(u).remove(graph.get(u).size() - 1));
            }
        }

        Collections.reverse(result);
        for (int i = 0; i < result.size() - 1; i++) {
            result.get(i).add(result.get(i + 1).get(0));
        }

        return result;
    }
}