import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> contentMap = new HashMap<>();
        for (String path : paths) {
            String[] parts = path.split(" ");
            String directory = parts[0];
            for (int i = 1; i < parts.length; i++) {
                String fileInfo = parts[i];
                int contentStartIndex = fileInfo.indexOf('(');
                String fileName = fileInfo.substring(0, contentStartIndex);
                String content = fileInfo.substring(contentStartIndex + 1, fileInfo.length() - 1);
                contentMap.computeIfAbsent(content, k -> new ArrayList<>()).add(directory + "/" + fileName);
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (List<String> files : contentMap.values()) {
            if (files.size() > 1) {
                result.add(files);
            }
        }

        return result;
    }
}