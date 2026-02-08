bool validUtf8(int* data, int dataSize) {
    int count = 0;
    for (int i = 0; i < dataSize; i++) {
        if (count == 0) {
            if ((data[i] & 0x80) == 0) {
                continue;
            } else if ((data[i] & 0xE0) == 0xC0) {
                count = 1;
            } else if ((data[i] & 0xF0) == 0xE0) {
                count = 2;
            } else if ((data[i] & 0xF8) == 0xF0) {
                count = 3;
            } else {
                return false;
            }
        } else {
            if ((data[i] & 0xC0) != 0x80) {
                return false;
            }
            count--;
        }
    }
    return count == 0;
}