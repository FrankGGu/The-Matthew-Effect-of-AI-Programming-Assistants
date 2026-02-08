import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> contentToFilePaths = new HashMap<>();

        for (String path : paths) {
            String[] parts = path.split(" ");
            String directoryPath = parts[0];

            for (int i = 1; i < parts.length; i++) {
                String fileEntry = parts[i];
                int openParenIndex = fileEntry.indexOf('(');
                int closeParenIndex = fileEntry.indexOf(')');

                String fileName = fileEntry.substring(0, openParenIndex);
                String content = fileEntry.substring(openParenIndex + 1, closeParenIndex);

                String fullFilePath = directoryPath + "/" + fileName;

                contentToFilePaths.computeIfAbsent(content, k -> new ArrayList<>()).add(fullFilePath);
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (List<String> fileList : contentToFilePaths.values()) {
            if (fileList.size() > 1) {
                result.add(fileList);
            }
        }

        return result;
    }
}