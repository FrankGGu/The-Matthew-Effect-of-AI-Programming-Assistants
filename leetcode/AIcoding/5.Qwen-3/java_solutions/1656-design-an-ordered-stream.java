public class Solution {

import java.util.*;

public class OrderedStream {
    private String[] data;
    private int ptr;
    private int size;

    public OrderedStream(int n) {
        data = new String[n];
        ptr = 0;
        size = n;
    }

    public List<String> insert(int id, String value) {
        data[id - 1] = value;
        List<String> result = new ArrayList<>();
        while (ptr < size && data[ptr] != null) {
            result.add(data[ptr]);
            ptr++;
        }
        return result;
    }
}
}