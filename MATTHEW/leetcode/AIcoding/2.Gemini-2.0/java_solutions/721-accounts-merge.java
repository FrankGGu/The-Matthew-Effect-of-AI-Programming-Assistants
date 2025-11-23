import java.util.*;

class Solution {
    public List<List<String>> accountsMerge(List<List<String>> accounts) {
        Map<String, String> emailToName = new HashMap<>();
        Map<String, Integer> emailToId = new HashMap<>();
        int emailCount = 0;
        for (List<String> account : accounts) {
            String name = account.get(0);
            for (int i = 1; i < account.size(); i++) {
                String email = account.get(i);
                if (!emailToId.containsKey(email)) {
                    emailToId.put(email, emailCount++);
                }
                emailToName.put(email, name);
            }
        }

        UnionFind uf = new UnionFind(emailCount);
        for (List<String> account : accounts) {
            String firstEmail = account.get(1);
            int firstId = emailToId.get(firstEmail);
            for (int i = 2; i < account.size(); i++) {
                String nextEmail = account.get(i);
                int nextId = emailToId.get(nextEmail);
                uf.union(firstId, nextId);
            }
        }

        Map<Integer, List<String>> idToEmails = new HashMap<>();
        for (String email : emailToId.keySet()) {
            int id = uf.find(emailToId.get(email));
            idToEmails.computeIfAbsent(id, k -> new ArrayList<>()).add(email);
        }

        List<List<String>> res = new ArrayList<>();
        for (int id : idToEmails.keySet()) {
            List<String> emails = idToEmails.get(id);
            Collections.sort(emails);
            String name = emailToName.get(emails.get(0));
            List<String> account = new ArrayList<>();
            account.add(name);
            account.addAll(emails);
            res.add(account);
        }
        return res;
    }

    private class UnionFind {
        private int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                parent[rootI] = rootJ;
            }
        }

        public int find(int i) {
            if (parent[i] != i) {
                parent[i] = find(parent[i]);
            }
            return parent[i];
        }
    }
}