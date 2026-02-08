class Solution {
    public int maxDiff(int num) {
        String s = String.valueOf(num);
        int max = num;
        int min = num;
        for (int i = 0; i < s.length(); i++) {
            char digit = s.charAt(i);
            String maxStr = s.replace(digit, '9');
            max = Math.max(max, Integer.parseInt(maxStr));

            char firstDigit = s.charAt(0);
            if (firstDigit != '1') {
                String minStr = s.replace(firstDigit, '1');
                min = Math.min(min, Integer.parseInt(minStr));
            } else {
                for (int j = 1; j < s.length(); j++) {
                    char otherDigit = s.charAt(j);
                    if (otherDigit != '0' && otherDigit != '1') {
                        String minStr = s.replace(otherDigit, '0');
                        min = Math.min(min, Integer.parseInt(minStr));
                        break;
                    }
                }
            }
            break;
        }

        if (s.charAt(0) != '1') {
            String minStr = s.replace(s.charAt(0), '1');
            min = Math.min(min, Integer.parseInt(minStr));
        } else {
            boolean found = false;
            for(int i = 1; i < s.length(); i++){
                if(s.charAt(i) != '0' && s.charAt(i) != '1'){
                    String minStr = s.replace(s.charAt(i), '0');
                    min = Math.min(min, Integer.parseInt(minStr));
                    found = true;
                    break;
                }
            }
            if(!found){
                min = num;
            }
        }

        return max - min;
    }
}