class OrderedStream {
public:
    vector<string> stream;
    int ptr;

    OrderedStream(int n) : stream(n), ptr(0) {}

    vector<string> insert(int idKey, string value) {
        stream[idKey - 1] = value;
        vector<string> result;
        while (ptr < stream.size() && !stream[ptr].empty()) {
            result.push_back(stream[ptr]);
            ptr++;
        }
        return result;
    }
};