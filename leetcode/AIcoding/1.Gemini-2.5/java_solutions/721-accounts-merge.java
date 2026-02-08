import java.util.*;

class Solution {
    Map<String, String> parent;
    Map<String, String> emailToName;

    public String find(String s) {
        if (parent.get(s).equals(s)) {
            return s;
        }
        String root = find(parent.get(s));
        parent.put(s, root); // Path compression
        return root;
    }

    public void union(String s1, String s2) {
        String root1 = find(s1);
        String root2 = find(s2);
        if (!root1.equals(root2)) {
            parent.put(root1, root2); // Union by setting root1's parent to root2
        }
    }

    public List<List<String>> accountsMerge(List<List<String>> accounts) {
        parent = new HashMap<>();
        emailToName = new HashMap<>();

        for (List<String> account : accounts) {
            String name = account.get(0);
            for (int i = 1; i < account.size(); i++) {
                String email = account.get(i);
                if (!parent.containsKey(email)) {
                    parent.put(email, email); // Each email is its own parent initially
                }
                emailToName.put(email, name); // Store the name associated with this email
            }
        }

        for (List<String> account : accounts) {
            String firstEmail = account.get(1); 
            for (int i = 2; i < account.size(); i++) {
                union(firstEmail, account.get(i));
            }
        }

        Map<String, TreeSet<String>> mergedAccounts = new HashMap<>();
        for (List<String> account : accounts) {
            for (int i = 1; i < account.size(); i++) {
                String email = account.get(i);
                String root = find(email); 
                mergedAccounts.computeIfAbsent(root, k -> new TreeSet<>()).add(email);
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (Map.Entry<String, TreeSet<String>> entry : mergedAccounts.entrySet()) {
            String rootEmail = entry.getKey();
            TreeSet<String> emails = entry.getValue();

            List<String> accountList = new ArrayList<>();
            accountList.add(emailToName.get(rootEmail)); 
            accountList.addAll(emails); 

            result.add(accountList);
        }

        return result;
    }
}