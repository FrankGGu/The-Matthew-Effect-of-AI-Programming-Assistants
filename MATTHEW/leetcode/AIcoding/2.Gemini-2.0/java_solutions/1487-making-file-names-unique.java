import java.util.HashMap;
import java.util.Map;

class Solution {
    public String[] getFolderNames(String[] names) {
        String[] result = new String[names.length];
        Map<String, Integer> nameCount = new HashMap<>();

        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            if (!nameCount.containsKey(name)) {
                result[i] = name;
                nameCount.put(name, 1);
            } else {
                int k = nameCount.get(name);
                String newName = name + "(" + k + ")";
                while (nameCount.containsKey(newName)) {
                    k++;
                    newName = name + "(" + k + ")";
                }
                result[i] = newName;
                nameCount.put(newName, 1);
                nameCount.put(name, k + 1);
            }
        }

        return result;
    }
}