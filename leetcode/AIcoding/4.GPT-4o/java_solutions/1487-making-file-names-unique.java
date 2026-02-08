import java.util.HashMap;

public class Solution {
    public String[] getFolderNames(String[] names) {
        HashMap<String, Integer> map = new HashMap<>();
        String[] result = new String[names.length];

        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            if (!map.containsKey(name)) {
                result[i] = name;
                map.put(name, 1);
            } else {
                int count = map.get(name);
                String newName;
                do {
                    newName = name + "(" + count + ")";
                    count++;
                } while (map.containsKey(newName));
                result[i] = newName;
                map.put(newName, 1);
                map.put(name, count);
            }
        }
        return result;
    }
}