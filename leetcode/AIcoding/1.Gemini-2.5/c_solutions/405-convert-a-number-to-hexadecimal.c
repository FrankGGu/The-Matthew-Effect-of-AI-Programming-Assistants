static char result_buffer[9];

char *toHex(int num) {
    if (num == 0) {
        return "0";
    }

    char hexChars[] = "0123456789abcdef";
    char *p = result_buffer + 8;
    *p = '\0';
    p--;

    unsigned int u_num = (unsigned int)num;

    while (u_num > 0) {
        *p = hexChars[u_num & 0xF];
        u_num >>= 4;
        p--;
    }

    return p + 1;
}