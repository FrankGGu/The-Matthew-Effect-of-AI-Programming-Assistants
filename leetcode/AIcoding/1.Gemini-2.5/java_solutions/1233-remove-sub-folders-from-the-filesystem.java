import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<String> removeSubfolders(String[] folders) {
        Arrays.sort(folders);

        List<String> result = new ArrayList<>();
        if (folders.length == 0) {
            return result;
        }

        result.add(folders[0]);
        String lastNonSubfolder = folders[0];

        for (int i = 1; i < folders.length; i++) {
            String currentFolder = folders[i];

            // Check if currentFolder is a subfolder of lastNonSubfolder
            // It's a subfolder if it starts with lastNonSubfolder + "/"
            // Example: lastNonSubfolder = "/a", currentFolder = "/a/b"
            // "/a/b".startsWith("/a/") is true
            // Example: lastNonSubfolder = "/a", currentFolder = "/ab"
            // "/ab".startsWith("/a/") is false, which is correct
            if (!(currentFolder.startsWith(lastNonSubfolder + "/"))) {
                result.add(currentFolder);
                lastNonSubfolder = currentFolder;
            }
        }

        return result;
    }
}