class Solution {
    public String maximumTime(String time) {
        char[] timeChars = time.toCharArray();

        // Handle hours
        if (timeChars[0] == '?') {
            if (timeChars[1] == '?') {
                timeChars[0] = '2';
                timeChars[1] = '3';
            } else {
                if (timeChars[1] >= '4') {
                    timeChars[0] = '1';
                } else {
                    timeChars[0] = '2';
                }
            }
        } else {
            if (timeChars[1] == '?') {
                if (timeChars[0] == '2') {
                    timeChars[1] = '3';
                } else {
                    timeChars[1] = '9';
                }
            }
        }

        // Handle minutes
        if (timeChars[3] == '?') {
            timeChars[3] = '5';
        }
        if (timeChars[4] == '?') {
            timeChars[4] = '9';
        }

        return new String(timeChars);
    }
}