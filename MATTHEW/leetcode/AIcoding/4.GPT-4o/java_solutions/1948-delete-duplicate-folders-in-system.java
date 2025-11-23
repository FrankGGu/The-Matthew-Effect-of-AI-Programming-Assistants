import java.util.*;

class Solution {
    public List<String> deleteDuplicateFolder(String[] paths) {
        Map<String, List<String>> map = new HashMap<>();
        for (String path : paths) {
            String[] folders = path.split("/");
            StringBuilder sb = new StringBuilder();
            for (String folder : folders) {
                if (sb.length() > 0) sb.append("/");
                sb.append(folder);
                map.putIfAbsent(sb.toString(), new ArrayList<>());
                map.get(sb.toString()).add(folder);
            }
        }

        Set<String> duplicates = new HashSet<>();
        Set<String> visited = new HashSet<>();
        for (String key : map.keySet()) {
            if (visited.contains(key)) continue;
            List<String> children = map.get(key);
            Set<String> childSet = new HashSet<>(children);
            if (childSet.size() < children.size()) {
                duplicates.add(key);
            }
            visited.add(key);
        }

        List<String> result = new ArrayList<>();
        for (String path : paths) {
            StringBuilder sb = new StringBuilder();
            String[] folders = path.split("/");
            boolean isDuplicate = false;
            for (String folder : folders) {
                if (sb.length() > 0) sb.append("/");
                sb.append(folder);
                if (duplicates.contains(sb.toString())) {
                    isDuplicate = true;
                    break;
                }
            }
            if (!isDuplicate) result.add(path);
        }
        return result;
    }
}