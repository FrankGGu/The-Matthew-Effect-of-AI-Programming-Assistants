package main

func getEncryptedData(password []byte) []byte {
    result := make([]byte, len(password))
    for i := 0; i < len(password); i++ {
        result[i] = password[i] ^ 0x12
    }
    return result
}

func crackPassword(encryptedData []byte) []byte {
    result := make([]byte, len(encryptedData))
    for i := 0; i < len(encryptedData); i++ {
        result[i] = encryptedData[i] ^ 0x12
    }
    return result
}