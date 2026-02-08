public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> contentToFile = new HashMap<>();

        for (String path : paths) {
            String[] parts = path.split(" ");
            String directory = parts[0];

            for (int i = 1; i < parts.length; i++) {
                String file = parts[i];
                int start = file.indexOf('(');
                int end = file.indexOf(')');
                String content = file.substring(start + 1, end);
                String fileName = file.substring(0, start);

                contentToFile.putIfAbsent(content, new ArrayList<>());
                contentToFile.get(content).add(directory + "/" + fileName);
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (List<String> files : contentToFile.values()) {
            if (files.size() > 1) {
                result.add(files);
            }
        }

        return result;
    }
}
}