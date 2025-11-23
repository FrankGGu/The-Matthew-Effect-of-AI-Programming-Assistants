import java.util.*;

class Solution {
    public List<List<String>> accountsMerge(List<List<String>> accounts) {
        Map<String, String> emailToName = new HashMap<>();
        Map<String, List<String>> graph = new HashMap<>();

        for (List<String> account : accounts) {
            String name = account.get(0);
            for (int i = 1; i < account.size(); i++) {
                String email = account.get(i);
                emailToName.put(email, name);
                graph.putIfAbsent(email, new ArrayList<>());
                if (i > 1) {
                    graph.get(account.get(i)).add(account.get(i - 1));
                    graph.get(account.get(i - 1)).add(account.get(i));
                }
            }
        }

        Set<String> visited = new HashSet<>();
        List<List<String>> mergedAccounts = new ArrayList<>();

        for (String email : emailToName.keySet()) {
            if (!visited.contains(email)) {
                List<String> emailsList = new ArrayList<>();
                dfs(email, visited, emailsList, graph);
                Collections.sort(emailsList);
                emailsList.add(0, emailToName.get(email));
                mergedAccounts.add(emailsList);
            }
        }

        return mergedAccounts;
    }

    private void dfs(String email, Set<String> visited, List<String> emailsList, Map<String, List<String>> graph) {
        visited.add(email);
        emailsList.add(email);
        for (String neighbor : graph.get(email)) {
            if (!visited.contains(neighbor)) {
                dfs(neighbor, visited, emailsList, graph);
            }
        }
    }
}