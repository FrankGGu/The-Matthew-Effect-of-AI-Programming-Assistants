import java.util.*;

class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> fileMap = new HashMap<>();
        for (String path : paths) {
            String[] parts = path.split(" ");
            String directory = parts[0];
            for (int i = 1; i < parts.length; i++) {
                String file = parts[i];
                int contentStart = file.indexOf('(');
                String fileName = file.substring(0, contentStart);
                String content = file.substring(contentStart + 1, file.length() - 1);
                fileMap.computeIfAbsent(content, k -> new ArrayList<>()).add(directory + "/" + fileName);
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