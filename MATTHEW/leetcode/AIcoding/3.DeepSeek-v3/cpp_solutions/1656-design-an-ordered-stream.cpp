class OrderedStream {
private:
    vector<string> stream;
    int ptr;
public:
    OrderedStream(int n) {
        stream.resize(n + 1);
        ptr = 1;
    }

    vector<string> insert(int idKey, string value) {
        stream[idKey] = value;
        vector<string> result;
        while (ptr < stream.size() && !stream[ptr].empty()) {
            result.push_back(stream[ptr]);
            ptr++;
        }
        return result;
    }
};