import java.util.HashMap;
import java.util.Map;

class Solution {
    public String[] getFolderNames(String[] names) {
        Map<String, Integer> map = new HashMap<>();
        String[] result = new String[names.length];

        for (int i = 0; i < names.length; i++) {
            String currentName = names[i];
            if (!map.containsKey(currentName)) {
                result[i] = currentName;
                map.put(currentName, 1);
            } else {
                int k = map.get(currentName);
                String newName = currentName + "(" + k + ")";

                while (map.containsKey(newName)) {
                    map.put(currentName, k + 1); // Path compression: update next suffix for currentName
                    k++;
                    newName = currentName + "(" + k + ")";
                }

                result[i] = newName;
                map.put(newName, 1); // newName is now used, next suffix for it is 1
                map.put(currentName, k + 1); // Update the next suffix for the original currentName
            }
        }

        return result;
    }
}