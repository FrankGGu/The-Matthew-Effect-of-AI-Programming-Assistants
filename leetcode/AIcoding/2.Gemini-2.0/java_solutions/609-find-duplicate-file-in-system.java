import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> contentMap = new HashMap<>();
        for (String path : paths) {
            String[] parts = path.split(" ");
            String dir = parts[0];
            for (int i = 1; i < parts.length; i++) {
                String file = parts[i];
                int index = file.indexOf('(');
                String fileName = file.substring(0, index);
                String content = file.substring(index + 1, file.length() - 1);
                contentMap.computeIfAbsent(content, k -> new ArrayList<>()).add(dir + "/" + fileName);
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