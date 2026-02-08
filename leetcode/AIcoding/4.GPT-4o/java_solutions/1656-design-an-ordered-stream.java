import java.util.ArrayList;
import java.util.List;

class OrderedStream {
    private String[] arr;
    private int ptr;

    public OrderedStream(int n) {
        arr = new String[n + 1];
        ptr = 1;
    }

    public List<String> insert(int idKey, String value) {
        arr[idKey] = value;
        List<String> result = new ArrayList<>();
        while (ptr < arr.length && arr[ptr] != null) {
            result.add(arr[ptr]);
            ptr++;
        }
        return result;
    }
}