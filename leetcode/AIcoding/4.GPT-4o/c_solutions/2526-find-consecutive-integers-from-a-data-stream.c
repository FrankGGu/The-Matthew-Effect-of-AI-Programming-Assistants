#define MAX_NUM 10000

typedef struct {
    int nums[MAX_NUM];
    int size;
} DataStream;

DataStream* dataStreamCreate(int* nums, int numsSize) {
    DataStream* stream = (DataStream*)malloc(sizeof(DataStream));
    memset(stream->nums, 0, sizeof(stream->nums));
    stream->size = numsSize;
    for (int i = 0; i < numsSize; i++) {
        stream->nums[nums[i]]++;
    }
    return stream;
}

bool dataStreamConsecutive(DataStream* stream) {
    for (int i = 0; i < MAX_NUM - 1; i++) {
        if (stream->nums[i] > 0 && stream->nums[i + 1] == 0) {
            return false;
        }
    }
    return true;
}

void dataStreamFree(DataStream* stream) {
    free(stream);
}