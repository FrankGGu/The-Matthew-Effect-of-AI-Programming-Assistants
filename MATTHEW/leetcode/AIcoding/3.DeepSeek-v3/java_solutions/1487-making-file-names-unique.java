class Solution {
    public String[] getFolderNames(String[] names) {
        Map<String, Integer> map = new HashMap<>();
        String[] result = new String[names.length];
        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            if (!map.containsKey(name)) {
                result[i] = name;
                map.put(name, 1);
            } else {
                int k = map.get(name);
                String newName = name + "(" + k + ")";
                while (map.containsKey(newName)) {
                    k++;
                    newName = name + "(" + k + ")";
                }
                result[i] = newName;
                map.put(name, k + 1);
                map.put(newName, 1);
            }
        }
        return result;
    }
}