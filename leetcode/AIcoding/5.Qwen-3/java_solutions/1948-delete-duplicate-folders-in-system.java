public class Solution {

import java.util.*;

public class Solution {
    public List<String> deleteDuplicateFolders(Map<String, Map<String, String>> tree) {
        Map<String, Integer> hashCount = new HashMap<>();
        Map<String, String> hashToFolder = new HashMap<>();
        Set<String> duplicateFolders = new HashSet<>();

        buildHashes(tree, hashCount, hashToFolder);

        for (Map.Entry<String, Integer> entry : hashCount.entrySet()) {
            if (entry.getValue() > 1) {
                duplicateFolders.add(entry.getKey());
            }
        }

        List<String> result = new ArrayList<>();
        for (String folder : hashToFolder.keySet()) {
            if (!duplicateFolders.contains(folder)) {
                result.add(folder);
            }
        }

        return result;
    }

    private void buildHashes(Map<String, Map<String, String>> tree, Map<String, Integer> hashCount, Map<String, String> hashToFolder) {
        for (Map.Entry<String, Map<String, String>> entry : tree.entrySet()) {
            String folder = entry.getKey();
            Map<String, String> children = entry.getValue();

            StringBuilder sb = new StringBuilder();
            for (Map.Entry<String, String> childEntry : children.entrySet()) {
                sb.append(childEntry.getKey()).append(":").append(childEntry.getValue()).append(";");
            }

            String hash = sb.toString();
            hashToFolder.put(hash, folder);
            hashCount.put(hash, hashCount.getOrDefault(hash, 0) + 1);

            buildHashes(children, hashCount, hashToFolder);
        }
    }
}
}