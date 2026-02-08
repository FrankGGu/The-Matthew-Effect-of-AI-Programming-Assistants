public class Solution {

import java.util.*;
import java.util.regex.*;

public class Solution {
    public List<String> findValidEmails(String[] emails) {
        List<String> result = new ArrayList<>();
        String pattern = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$";
        Pattern regex = Pattern.compile(pattern);
        for (String email : emails) {
            Matcher matcher = regex.matcher(email);
            if (matcher.matches()) {
                result.add(email);
            }
        }
        return result;
    }
}
}