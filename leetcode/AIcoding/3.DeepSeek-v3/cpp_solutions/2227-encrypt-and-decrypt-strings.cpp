class Encrypter {
public:
    unordered_map<char, string> encMap;
    unordered_map<string, int> decCount;

    Encrypter(vector<char>& keys, vector<string>& values, vector<string>& dictionary) {
        for (int i = 0; i < keys.size(); ++i) {
            encMap[keys[i]] = values[i];
        }
        for (const string& word : dictionary) {
            string encrypted = encrypt(word);
            decCount[encrypted]++;
        }
    }

    string encrypt(string word1) {
        string res;
        for (char c : word1) {
            if (encMap.find(c) != encMap.end()) {
                res += encMap[c];
            } else {
                return "";
            }
        }
        return res;
    }

    int decrypt(string word2) {
        return decCount[word2];
    }
};