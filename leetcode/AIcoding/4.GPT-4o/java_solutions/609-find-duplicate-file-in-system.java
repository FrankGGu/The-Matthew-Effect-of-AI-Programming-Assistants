import java.util.*;

class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> fileMap = new HashMap<>();

        for (String path : paths) {
            String[] parts = path.split(" ");
            String root = parts[0];
            for (int i = 1; i < parts.length; i++) {
                String[] fileParts = parts[i].split("\\(");
                String fileName = fileParts[0];
                String content = fileParts[1].substring(0, fileParts[1].length() - 1);
                String fullPath = root + "/" + fileName;

                fileMap.putIfAbsent(content, new ArrayList<>());
                fileMap.get(content).add(fullPath);
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (List<String> files : fileMap.values()) {
            if (files.size() > 1) {
                result.add(files);
            }
        }

        return result;
    }
}