import java.util.*;

class Solution {

    public int[] sortItems(int n, int m, int[] group, List<List<Integer>> beforeItems) {
        // 1. Assign a unique virtual group to items not belonging to any group
        int currentGroupCount = m;
        int[] adjustedGroup = new int[n];
        for (int i = 0; i < n; i++) {
            if (group[i] == -1) {
                adjustedGroup[i] = currentGroupCount++;
            } else {
                adjustedGroup[i] = group[i];
            }
        }
        int totalGroups = currentGroupCount;

        // 2. Build Item-Level Graph and calculate in-degrees
        List<List<Integer>> itemAdj = new ArrayList<>();
        int[] itemInDegree = new int[n];
        for (int i = 0; i < n; i++) {
            itemAdj.add(new ArrayList<>());
        }
        for (int i = 0; i < n; i++) {
            for (int prev : beforeItems.get(i)) {
                itemAdj.get(prev).add(i);
                itemInDegree[i]++;
            }
        }

        // 3. Build Group-Level Graph and calculate in-degrees
        List<Set<Integer>> groupAdjSet = new ArrayList<>(); // Use Set to avoid duplicate edges
        int[] groupInDegree = new int[totalGroups];
        for (int i = 0; i < totalGroups; i++) {
            groupAdjSet.add(new HashSet<>());
        }
        for (int i = 0; i < n; i++) {
            int g_i = adjustedGroup[i];
            for (int prev : beforeItems.get(i)) {
                int g_prev = adjustedGroup[prev];
                if (g_prev != g_i) { // Dependency between items in different groups
                    if (groupAdjSet.get(g_prev).add(g_i)) { // Add returns true if element was new
                        groupInDegree[g_i]++;
                    }
                }
            }
        }
        // Convert groupAdjSet to List<List<Integer>> for topological sort function
        List<List<Integer>> finalGroupAdj = new ArrayList<>();
        for (int i = 0; i < totalGroups; i++) {
            finalGroupAdj.add(new ArrayList<>(groupAdjSet.get(i)));
        }

        // 4. Perform Topological Sort for Items
        List<Integer> itemOrder = topologicalSort(n, itemAdj, itemInDegree);
        if (itemOrder.isEmpty()) {
            return new int[0]; // Cycle detected in item dependencies
        }

        // 5. Perform Topological Sort for Groups
        List<Integer> groupOrder = topologicalSort(totalGroups, finalGroupAdj, groupInDegree);
        if (groupOrder.isEmpty()) {
            return new int[0]; // Cycle detected in group dependencies
        }

        // 6. Combine results
        // Map each group to its topologically sorted items
        List<List<Integer>> groupToItems = new ArrayList<>();
        for (int i = 0; i < totalGroups; i++) {
            groupToItems.add(new ArrayList<>());
        }
        for (int item : itemOrder) {
            groupToItems.get(adjustedGroup[item]).add(item);
        }

        // Construct the final answer based on group order and item order within groups
        int[] ans = new int[n];
        int idx = 0;
        for (int g : groupOrder) {
            for (int item : groupToItems.get(g)) {
                ans[idx++] = item;
            }
        }

        return ans;
    }

    // Helper function for Kahn's algorithm (topological sort)
    private List<Integer> topologicalSort(int nodes, List<List<Integer>> adj, int[] inDegree) {
        List<Integer> result = new ArrayList<>();
        Queue<Integer> q = new LinkedList<>();

        for (int i = 0; i < nodes; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            result.add(u);

            for (int v : adj.get(u)) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // If the size of the result list is not equal to the number of nodes, a cycle exists
        return result.size() == nodes ? result : new ArrayList<>();
    }
}