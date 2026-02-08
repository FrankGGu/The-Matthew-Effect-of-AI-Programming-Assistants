public class Solution {

import java.util.*;

public class Solution {
    public List<String> removeSubfolders(String[] folders) {
        Arrays.sort(folders);
        List<String> result = new ArrayList<>();
        String prev = "";
        for (String folder : folders) {
            if (!prev.startsWith(folder + "/")) {
                result.add(folder);
                prev = folder;
            }
        }
        return result;
    }
}
}