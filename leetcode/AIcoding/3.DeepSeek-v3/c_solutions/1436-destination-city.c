char * destCity(char *** paths, int pathsSize, int* pathsColSize){
    for(int i = 0; i < pathsSize; i++){
        int found = 0;
        for(int j = 0; j < pathsSize; j++){
            if(strcmp(paths[i][1], paths[j][0]) == 0){
                found = 1;
                break;
            }
        }
        if(!found){
            return paths[i][1];
        }
    }
    return "";
}