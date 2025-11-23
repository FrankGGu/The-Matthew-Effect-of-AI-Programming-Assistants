typedef struct {
    char *data;
    int top;
} Stack;

char* minRemoveToMakeValid(char* s) {
    int len = strlen(s);
    Stack st;
    st.data = (char*)malloc((len + 1) * sizeof(char));
    st.top = -1;

    int *remove = (int*)calloc(len, sizeof(int));

    for (int i = 0; i < len; i++) {
        if (s[i] == '*') {
            if (st.top >= 0) {
                remove[st.data[st.top]] = 1;
                remove[i] = 1;
                st.top--;
            }
        } else {
            st.top++;
            st.data[st.top] = i;
        }
    }

    char *result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;
    for (int i = 0; i < len; i++) {
        if (!remove[i]) {
            result[idx++] = s[i];
        }
    }
    result[idx] = '\0';

    free(st.data);
    free(remove);
    return result;
}