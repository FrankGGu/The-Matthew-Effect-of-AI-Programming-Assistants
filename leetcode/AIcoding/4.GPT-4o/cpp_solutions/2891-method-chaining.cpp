class StringBuilder {
public:
    StringBuilder() {
        str = "";
    }

    StringBuilder& append(const string& s) {
        str += s;
        return *this;
    }

    StringBuilder& appendLine(const string& s) {
        str += s + "\n";
        return *this;
    }

    string toString() {
        return str;
    }

private:
    string str;
};