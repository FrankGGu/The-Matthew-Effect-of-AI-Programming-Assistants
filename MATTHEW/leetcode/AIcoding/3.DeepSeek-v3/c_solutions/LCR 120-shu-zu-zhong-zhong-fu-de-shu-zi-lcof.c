int findRepeatDocument(int* documents, int documentsSize) {
    for (int i = 0; i < documentsSize; i++) {
        while (documents[i] != i) {
            if (documents[i] == documents[documents[i]]) {
                return documents[i];
            }
            int temp = documents[i];
            documents[i] = documents[temp];
            documents[temp] = temp;
        }
    }
    return -1;
}