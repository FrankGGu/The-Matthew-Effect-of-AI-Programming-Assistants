package main

func validateUTF8(data []int) bool {
    if len(data) == 0 {
        return true
    }

    for i := 0; i < len(data); {
        b := data[i]
        if b&0x80 == 0 {
            i++
            continue
        } else if b&0xE0 == 0xC0 {
            if i+1 >= len(data) {
                return false
            }
            if data[i+1]&0xC0 != 0x80 {
                return false
            }
            i += 2
        } else if b&0xF0 == 0xE0 {
            if i+2 >= len(data) {
                return false
            }
            if data[i+1]&0xC0 != 0x80 || data[i+2]&0xC0 != 0x80 {
                return false
            }
            i += 3
        } else if b&0xF8 == 0xF0 {
            if i+3 >= len(data) {
                return false
            }
            if data[i+1]&0xC0 != 0x80 || data[i+2]&0xC0 != 0x80 || data[i+3]&0xC0 != 0x80 {
                return false
            }
            i += 4
        } else {
            return false
        }
    }
    return true
}