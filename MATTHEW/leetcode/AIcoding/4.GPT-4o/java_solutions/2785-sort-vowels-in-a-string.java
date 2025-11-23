class Solution {
    public String sortVowels(String s) {
        char[] arr = s.toCharArray();
        List<Character> vowels = new ArrayList<>();

        for (char c : arr) {
            if ("aeiouAEIOU".indexOf(c) >= 0) {
                vowels.add(c);
            }
        }

        Collections.sort(vowels);

        int index = 0;
        for (int i = 0; i < arr.length; i++) {
            if ("aeiouAEIOU".indexOf(arr[i]) >= 0) {
                arr[i] = vowels.get(index++);
            }
        }

        return new String(arr);
    }
}